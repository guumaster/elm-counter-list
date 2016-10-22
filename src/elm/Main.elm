module Main exposing (..)

import Html.App as App
import Model exposing (..)
import View exposing (..)
import Update exposing (..)


main : Program Never
main =
    App.beginnerProgram
        { model = model
        , view = view
        , update = update
        }
