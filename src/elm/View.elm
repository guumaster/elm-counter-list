module View exposing (view)

import Html exposing (..)
import Html.Events exposing (onClick, onInput)
import Html.Attributes exposing (..)
import Model exposing (..)
import Update exposing (..)


view : Model -> Html Action
view { counters, counterName } =
    div []
        [ div [] []
        , contentWrapper <|
            [ header
            , counterInput counterName
            , divider
            , counterList counters
            ]
        ]


contentWrapper : List (Html Action) -> Html Action
contentWrapper =
    div [ class "ui center aligned raised very padded text container segment" ]


divider : Html Action
divider =
    div [ class "ui horizontal divider" ] []


header : Html Action
header =
    h1 [ class "ui header" ] [ text "Counter List" ]


counterInput : CounterName -> Html Action
counterInput name =
    div [ class "ui action input " ]
        [ input
            [ type' "text"
            , placeholder "Counter..."
            , value name
            , onInput UpdateName
            ]
            []
        , button
            [ class "ui teal icon button"
            , onClick (Create)
            ]
            [ i [ class "add icon" ] []
            ]
        ]


counterList : List Counter -> Html Action
counterList counters =
    div [ class "ui cards" ]
        (List.map counterItem counters)


counterItem : Counter -> Html Action
counterItem { id, total, name } =
    let
        changeButton sign msg =
            button
                [ class "ui basic teal icon button"
                , onClick msg
                ]
                [ i [ class (sign ++ " icon") ] [] ]

        removeButton id =
            button
                [ class "basic red mini ui icon button"
                , onClick (Remove id)
                ]
                [ i [ class "remove icon" ] [] ]

        counterLabel =
            div [ class "ui basic big " ]
                [ text ("Total: " ++ toString total ++ " ")
                ]
    in
        div [ class "raised link card" ]
            [ div [ class "content" ]
                [ div [ class "right floated ui" ]
                    [ removeButton id
                    ]
                , div [ class "header" ] [ text name ]
                ]
            , div
                [ class "content middle aligned" ]
                [ counterLabel
                ]
            , div [ class "extra content" ]
                [ div [ class "ui icon compact two buttons" ]
                    [ changeButton "angle up" (Increment id)
                    , changeButton "angle down" (Decrement id)
                    ]
                ]
            ]
