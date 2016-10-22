module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.App as App
import Html.Attributes exposing (..)


type alias Model =
    { counter : Int
    }


type Action
    = Increment
    | Decrement


model : Model
model =
    { counter = 0
    }


view : Model -> Html Action
view model =
    let
        negativeCounter =
            model.counter < 0
    in
        div []
            [ div [ class "ui center aligned container" ]
                [ h1 [ class "ui header" ] [ text "Simple Counter" ]
                , div []
                    [ button
                        [ class "ui primary button"
                        , onClick Decrement
                        ]
                        [ text "+" ]
                    , span [ class "ui large label" ]
                        [ text (" " ++ toString model.counter ++ " ")
                        ]
                    , button
                        [ class "ui primary button"
                        , onClick Decrement
                        ]
                        [ text "-" ]
                    ]
                ]
            ]


update : Action -> Model -> Model
update action model =
    case action of
        Increment ->
            { model | counter = model.counter + 1 }

        Decrement ->
            { model | counter = model.counter - 1 }


main : Program Never
main =
    App.beginnerProgram
        { model = model
        , view = view
        , update = update
        }
