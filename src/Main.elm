module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Html.App as App


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
    div []
        [ text "Simple Counter"
        , div []
            [ button [ onClick Increment ] [ text "+" ]
            , span []
                [ text (" " ++ toString model.counter ++ " ")
                ]
            , button [ onClick Decrement ] [ text "-" ]
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
