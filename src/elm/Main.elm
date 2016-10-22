module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick, onInput)
import Html.App as App
import Html.Attributes exposing (..)


type alias CounterId =
    Int


type alias CounterName =
    String


type alias Counter =
    ( CounterId, CounterData )


type alias CounterData =
    { name : String
    , total : Int
    }


type alias Model =
    { counters : List Counter
    , lastId : CounterId
    , counterName : String
    }


type Sign
    = Plus
    | Minus


type Action
    = Increment CounterId
    | Decrement CounterId
    | Remove CounterId
    | Create
    | UpdateName CounterName


model : Model
model =
    { counters =
        [ ( 0, CounterData "Things" 0 )
        , ( 1, CounterData "More things" 0 )
        ]
    , lastId = 1
    , counterName = ""
    }


view : Model -> Html Action
view model =
    let
        header =
            h1 [ class "ui header" ] [ text "Counter List" ]

        divider =
            div [ class "ui horizontal divider" ] []
    in
        div []
            [ div [] []
            , div [ class "ui center aligned raised very padded text container segment" ]
                [ header
                , createCounter model.counterName
                , divider
                , counterList model.counters
                ]
            ]


createCounter : CounterName -> Html Action
createCounter name =
    div [ class "ui action input " ]
        [ input
            [ type' "text"
            , placeholder "Counter..."
            , value name
            , onInput UpdateName
            ]
            []
        , button
            [ class "ui teal icon button"
            , onClick (Create)
            ]
            [ i [ class "add icon" ] []
            ]
        ]


counterList : List Counter -> Html Action
counterList counters =
    div [ class "ui cards" ]
        (List.map counterItem counters)


counterItem : Counter -> Html Action
counterItem ( id, counter ) =
    let
        changeButton sign msg =
            button
                [ class "ui basic teal icon button"
                , onClick msg
                ]
                [ i [ class (sign ++ " icon") ] [] ]

        removeButton id =
            button
                [ class "basic red mini ui icon button"
                , onClick (Remove id)
                ]
                [ i [ class "remove icon" ] [] ]

        counterLabel =
            div [ class "ui basic big " ]
                [ text ("Total: " ++ toString counter.total ++ " ")
                ]
    in
        div [ class "raised link card" ]
            [ div [ class "content" ]
                [ div [ class "right floated ui" ]
                    [ removeButton id
                    ]
                , div [ class "header" ] [ text counter.name ]
                ]
            , div
                [ class "content middle aligned" ]
                [ counterLabel
                ]
            , div [ class "extra content" ]
                [ div [ class "ui icon compact two buttons" ]
                    [ changeButton "angle up" (Increment id)
                    , changeButton "angle down" (Decrement id)
                    ]
                ]
            ]


update : Action -> Model -> Model
update action model =
    let
        incrementCounter =
            updateCounter Plus

        decrementCounter =
            updateCounter Minus

        removeCounter removeId ( id, counter ) =
            removeId /= id
    in
        case action of
            Increment counterId ->
                { model | counters = List.map (incrementCounter counterId) model.counters }

            Decrement counterId ->
                { model | counters = List.map (decrementCounter counterId) model.counters }

            Remove counterId ->
                { model | counters = List.filter (removeCounter counterId) model.counters }

            Create ->
                addCounter model

            UpdateName name ->
                { model | counterName = name }


addCounter : Model -> Model
addCounter model =
    let
        newId =
            model.lastId + 1

        newCounter =
            ( newId, CounterData model.counterName 0 )
    in
        { model | counters = [ newCounter ] ++ model.counters, lastId = newId, counterName = "" }


updateCounter : Sign -> CounterId -> Counter -> Counter
updateCounter sign counterId ( id, counter ) =
    let
        op =
            case sign of
                Plus ->
                    (+)

                Minus ->
                    (-)
    in
        if counterId == id then
            ( id, { counter | total = Basics.max 0 <| op counter.total 1 } )
        else
            ( id, counter )


main : Program Never
main =
    App.beginnerProgram
        { model = model
        , view = view
        , update = update
        }
