module Main exposing (main)

import TimeTravel.Html.App as TimeTravel
import Model exposing (model)
import View exposing (view)
import Update exposing (update)


main : Program Never
main =
    TimeTravel.program
        { init = model ! []
        , view = view
        , update = update
        , subscriptions = (\_ -> Sub.none)
        }
