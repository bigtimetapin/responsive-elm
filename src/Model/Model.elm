module Model.Model exposing (Model, init)

import Browser.Dom
import Model.WindowSize exposing (WindowSize)
import Msg.Msg exposing (Msg(..))
import State.State exposing (State(..))
import Task


type alias Model =
    { state : State
    , windowSize : Maybe WindowSize
    }


init : ( Model, Cmd Msg )
init =
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
