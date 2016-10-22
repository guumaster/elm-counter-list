module Model exposing (..)


type alias Model =
    { counters : List Counter
    , lastId : CounterId
    , counterName : String
    }


type alias CounterId =
    Int


type alias CounterName =
    String


type alias Counter =
    { id : Int
    , name : String
    , total : Int
    }


type Sign
    = Plus
    | Minus


model : Model
model =
    { counters =
        [ Counter 0 "Things" 0
        , Counter 1 "More things" 0
        ]
    , lastId = 1
    , counterName = ""
    }
