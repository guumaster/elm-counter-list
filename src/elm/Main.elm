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
            [ div [ class "ui center aligned container" ]
                [ header
                , counterList model.counters
                ]
            ]


counterList : List Counter -> Html Action
counterList counters =
    div [ class "ui divided items" ] <| List.map counterItem counters


counterItem : Counter -> Html Action
counterItem ( id, total ) =
    let
        changeButton sign msg =
            button
                [ class "ui icon button"
                , onClick msg
                ]
                [ i [ class (sign ++ " icon") ] [] ]

        counterLabel =
            span [ class "ui basic label" ]
                [ text ("Counter: " ++ toString total ++ " ")
                ]
    in
        div [ class "item" ]
            [ counterLabel
            , div [ class "ui icon buttons" ]
                [ changeButton "plus" (Increment id)
                , changeButton "minus" (Decrement id)
                ]
            ]


update : Action -> Model -> Model
update action model =
    let
        incrementCounter =
            updateCounter Plus

        decrementCounter =
            updateCounter Minus
    in
        case action of
            Increment counterId ->
                { model | counters = List.map (incrementCounter counterId) model.counters }

            Decrement counterId ->
                { model | counters = List.map (decrementCounter counterId) model.counters }


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
