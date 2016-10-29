module Main exposing (..)

--import Html.App as App -- change to this import to remove time travel debug

import TimeTravel.Html.App as TimeTravel
import Model exposing (..)
import View exposing (..)
import Update exposing (..)


init : ( Model, Cmd Action )
init =
    model ! []


main : Program Never
main =
    -- App.program
    TimeTravel.program
        { init = init
        , view = view
        , update = update
        , subscriptions = (\_ -> Sub.none)
        }
