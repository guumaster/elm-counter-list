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
        header =
            h1 [ class "ui header" ] [ text "Simple Counter" ]
    in
        div []
            [ div [ class "ui center aligned container" ]
                [ header
                , counter model
                ]
            ]


counter : Model -> Html Action
counter model =
    let
        changeButton sign msg =
            span
                [ onClick msg
                ]
                [ i [ class (sign ++ " icon") ] [] ]

        counterLabel =
            span [ class "ui basic right pointing label" ]
                [ text ("Counter:  " ++ toString model.counter ++ " ")
                ]
    in
        div [ class "ui left labeled button" ]
            [ counterLabel
            , div [ class "ui icon button" ]
                [ changeButton "plus" Increment
                , changeButton "minus" Decrement
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
