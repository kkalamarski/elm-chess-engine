module Main exposing (..)

import Browser
import ChessBoard exposing (chessBoard)
import Model exposing (Model, Msg, init, update)
import Html exposing (Html)


main : Program () Model Msg
main =
    Browser.sandbox { init = init, view = view, update = update }


view : Model -> Html Msg
view model =
    chessBoard model
