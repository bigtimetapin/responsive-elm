module Main exposing (main)

-- MAIN

import Browser
import Browser.Dom
import Element exposing (Element)
import Element.Background as Background
import Element.Font as Font
import Html exposing (Html)
import Task exposing (Task)


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }



-- MODEL


type alias Model =
    { state : State
    , windowSize : Maybe WindowSize
    }


type alias WindowSize =
    { width : Float
    , height : Float
    }


type State
    = LandingPage


type Msg
    = NewWindowSize (Maybe WindowSize)


init : () -> ( Model, Cmd Msg )
init _ =
    let
        handle : Result x Browser.Dom.Viewport -> Msg
        handle result =
            case result of
                Ok viewport ->
                    NewWindowSize
                        (Just
                            { width = viewport.viewport.width
                            , height = viewport.viewport.height
                            }
                        )

                Err _ ->
                    NewWindowSize Nothing
    in
    ( { state = LandingPage
      , windowSize = Nothing
      }
    , Task.attempt handle Browser.Dom.getViewport
    )



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
                    ]
                )


viewWindowDimension : Model -> (WindowSize -> Float) -> String
viewWindowDimension model f =
    case Maybe.map f model.windowSize of
        Just float ->
            String.fromFloat float

        Nothing ->
            "Could not detect val"
