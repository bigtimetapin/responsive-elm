module Msg.Msg exposing (Msg(..), resetViewport)

import Browser
import Browser.Dom as Dom
import Task
import Url


type Msg
    = NoOp
    | UrlChanged Url.Url
    | LinkClicked Browser.UrlRequest


resetViewport : Cmd Msg
resetViewport =
    Task.perform (\_ -> NoOp) (Dom.setViewport 0 0)
