module Update exposing (update, Action(..))

import Model exposing (..)
import String exposing (trim)


type Action
    = Increment CounterId
    | Decrement CounterId
    | Remove CounterId
    | Create
    | UpdateName CounterName


update : Action -> Model -> ( Model, Cmd Action )
update action model =
    case action of
        Increment counterId ->
            { model | counters = incrementCounter counterId model.counters } ! []

        Decrement counterId ->
            { model | counters = decrementCounter counterId model.counters } ! []

        Create ->
            if (trim model.counterName) /= "" then
                addCounter model ! []
            else
                model ! []

        Remove counterId ->
            { model | counters = removeCounter counterId model.counters } ! []

        UpdateName name ->
            { model | counterName = name } ! []


incrementCounter : CounterId -> List Counter -> List Counter
incrementCounter counterId =
    List.map (updateCounter Plus counterId)


decrementCounter : CounterId -> List Counter -> List Counter
decrementCounter counterId =
    List.map (updateCounter Minus counterId)


updateCounter : Sign -> CounterId -> Counter -> Counter
updateCounter sign counterId counter =
    let
        op =
            case sign of
                Plus ->
                    (+)

                Minus ->
                    (-)
    in
        if counterId == counter.id then
            { counter | total = Basics.max 0 <| op counter.total 1 }
        else
            counter


addCounter : Model -> Model
addCounter model =
    let
        newId =
            model.lastId + 1

        newCounter =
            Counter newId (trim model.counterName) 0
    in
        { model | counters = [ newCounter ] ++ model.counters, lastId = newId, counterName = "" }


removeCounter : CounterId -> List Counter -> List Counter
removeCounter counterId =
    let
        removeCounter removeId counter =
            removeId /= counter.id
    in
        List.filter (removeCounter counterId)
