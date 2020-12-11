module Main exposing (main)

-- MAIN

import Browser
import Html exposing (Html)
import Html.Attributes exposing (class)
import Model.Model as Model exposing (Model)
import Model.Orientation as Orientation
import Model.State exposing (State(..))
import Model.WindowSize exposing (WindowSize)
import Msg.Msg exposing (Msg(..))
import Sub.Sub as Sub


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.onResize
        }


init : () -> ( Model, Cmd Msg )
init _ =
    Model.init



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NewWindowSize windowSize ->
            ( { model | windowSize = windowSize }, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    case model.state of
        LandingPage ->
            Html.section
                [ class "hero has-background-grey-lighter is-fullheight"
                ]
                [ Html.div
                    [ class "hero-body has-text-centered is-family-secondary"
                    ]
                    [ Html.div
                        [ class "container is-fluid"
                        ]
                        [ Html.div
                            [ class "columns is-mobile is-centered is-multiline"
                            ]
                            [ Html.div
                                [ class "column is-4"
                                ]
                                [ Html.text ("Width: " ++ viewWindowDimension model .width)
                                ]
                            , Html.div
                                [ class "column is-4"
                                ]
                                [ Html.text ("Height: " ++ viewWindowDimension model .height)
                                ]
                            , Html.div
                                [ class "column is-8-mobile"
                                ]
                                [ Html.text ("Orientation: " ++ viewOrientation model)
                                ]
                            ]
                        ]
                    ]
                , Html.div
                    [ class "hero-foot has-text-centered"
                    ]
                    [ Html.text "footer"
                    ]
                ]


viewWindowDimension : Model -> (WindowSize -> Int) -> String
viewWindowDimension model f =
    case Maybe.map f model.windowSize of
        Just int ->
            String.fromInt int

        Nothing ->
            "Could not detect val"


viewOrientation : Model -> String
viewOrientation model =
    case model.windowSize of
        Just ws ->
            Orientation.toString ws.orientation

        Nothing ->
            "Could not detect val"
