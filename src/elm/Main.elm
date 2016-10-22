module Main exposing (..)

import Html.App as App
import Model exposing (..)
import View exposing (..)
import Update exposing (..)


init : ( Model, Cmd Action )
init =
    model ! []


main : Program Never
main =
    App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = (\_ -> Sub.none)
        }
