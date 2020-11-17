module Main exposing (main)

-- MAIN

import Browser
import Element exposing (Element)
import Element.Background as Background
import Element.Font as Font
import Html exposing (Html)
import Model.Model as Model exposing (Model)
import Model.Orientation as Orientation
import Model.WindowSize exposing (WindowSize)
import Msg.Msg exposing (Msg(..))
import State.State exposing (State(..))
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
    Element.layout [] (elementView model)


elementView : Model -> Element Msg
elementView model =
    case model.state of
        LandingPage ->
            Element.el
                [ Element.width Element.fill
                , Element.height Element.fill
                , Background.color (Element.rgb255 135 206 250)
                ]
                (Element.column
                    [ Element.centerX
                    , Element.centerY
                    , Font.color (Element.rgb255 255 255 255)
                    , Font.size 100
                    ]
                    [ Element.text "Big Time Tap In"
                    , Element.text ("Width: " ++ viewWindowDimension model (\ws -> ws.width))
                    , Element.text ("Height: " ++ viewWindowDimension model (\ws -> ws.height))
                    , Element.text ("Orientation: " ++ viewOrientation model)
                    ]
                )


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
