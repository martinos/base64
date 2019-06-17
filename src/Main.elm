module Main exposing (main)

import Base64
import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type alias Model =
    { input : String }


type Msg
    = SetInput String


initModel : Model
initModel =
    { input = "" }


main =
    Browser.sandbox { init = initModel, update = update, view = view }


update msg model =
    case msg of
        SetInput str ->
            { model | input = str }


view : Model -> Html Msg
view model =
    div []
        [ stylesheet "https://cdnjs.cloudflare.com/ajax/libs/bulma/0.6.1/css/bulma.min.css"
        , section [ class "section" ]
            [ div [ class "container" ]
                [ h1 [ class "title" ]
                    [ text "Base64 Decode" ]
                , div [ class "columns" ]
                    [ div [ class "column is-half" ]
                        [ p [ class "subtitle" ] [ text "Input" ]
                        , Html.form []
                            [ textarea
                                [ class "textarea"
                                , attribute "rows" "30"
                                , placeholder "Enter your Base64"
                                , value model.input
                                , onInput SetInput
                                ]
                                []
                            ]
                        ]
                    , div [ class "column is-half" ]
                        [ p [ class "subtitle" ] [ text "Decoded" ]
                        , viewOutput model
                        ]
                    ]
                ]
            ]
        ]


viewOutput model =
    div [ class "row" ]
        [ case model.input |> String.replace "\n" "" |> String.replace " " "" |> String.replace "\u{000D}" "" |> Base64.decode of
            Ok decoded ->
                pre [ id "copy-me", style "position" "relative", style "white-space" "pre-wrap", style "word-wrap" "break-word" ]
                    [ decoded |> text, copyButton ]

            Err err ->
                text ("Error:" ++ err)
        ]


stylesheet : String -> Html msg
stylesheet url =
    node "link"
        [ rel "stylesheet"
        , href url
        ]
        []


copyButton =
    button
        [ class "copy-button button is-small"
        , attribute "data-clipboard-target" "#copy-me"
        , style "position" "absolute"
        , style "top" "0.25rem"
        , style "right" "0.25rem"
        ]
        [ "Copy" |> text ]
