module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.App as App
import Html.Attributes exposing (..)


type alias CounterId =
    Int


type alias Total =
    Int


type alias Counter =
    ( CounterId, Total )


type alias Model =
    { counters : List Counter
    , lastId : CounterId
    }


type Sign
    = Plus
    | Minus


type Action
    = Increment CounterId
    | Decrement CounterId
    | Remove CounterId
    | Create


model : Model
model =
    { counters =
        [ ( 0, 0 )
        , ( 1, 0 )
        ]
    , lastId = 1
    }


view : Model -> Html Action
view model =
    let
        header =
            h1 [ class "ui header" ] [ text "Counter List" ]
    in
        div []
            [ div [] []
            , div [ class "ui center aligned raised very padded text container segment" ]
                [ header
                , createCounter
                , counterList model.counters
                ]
            ]


createCounter : Html Action
createCounter =
    div []
        [ button
            [ class "ui teal labeled basic icon button"
            , onClick Create
            ]
            [ text "Create counter"
            , i [ class "add icon" ] []
            ]
        ]


counterList : List Counter -> Html Action
counterList counters =
    let
        divider =
            [ div [ class "ui horizontal divider" ] [] ]
    in
        div [ class "ui divided items" ]
            (divider ++ List.map counterItem counters)


counterItem : Counter -> Html Action
counterItem ( id, total ) =
    let
        isNegative =
            total < 0

        changeButton sign msg =
            button
                [ class "ui icon button"
                , onClick msg
                ]
                [ i [ class (sign ++ " icon") ] [] ]

        removeButton id =
            button
                [ class "ui negative basic icon button"
                , onClick (Remove id)
                ]
                [ i [ class "remove icon" ] [] ]

        counterLabel =
            div
                [ classList
                    [ ( "ui basic big label", True )
                    , ( "red", isNegative )
                    , ( "green", not <| isNegative )
                    ]
                ]
                [ text ("Counter: " ++ toString total ++ " ")
                ]
    in
        div [ class "item" ]
            [ div [ class "middle aligned" ]
                [ counterLabel
                , div [ class "ui icon basic teal buttons" ]
                    [ changeButton "angle up" (Increment id)
                    , changeButton "angle down" (Decrement id)
                    ]
                , span [] [ text " " ]
                , removeButton id
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


addCounter : Model -> Model
addCounter model =
    let
        newId =
            model.lastId + 1

        newCounter =
            ( newId, 0 )
    in
        { model | counters = [ newCounter ] ++ model.counters, lastId = newId }


updateCounter : Sign -> CounterId -> Counter -> Counter
updateCounter sign counterId ( id, total ) =
    let
        op =
            case sign of
                Plus ->
                    (+)

                Minus ->
                    (-)
    in
        if counterId == id then
            ( id, op total 1 )
        else
            ( id, total )


main : Program Never
main =
    App.beginnerProgram
        { model = model
        , view = view
        , update = update
        }
