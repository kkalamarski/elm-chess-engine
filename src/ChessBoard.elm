module ChessBoard exposing (..)

import Html exposing (Html, button, div, text)
import Html.Events
import List
import Model exposing (Model, Msg(..))
import Styles exposing (..)
import Tile exposing (..)
import FEN exposing (..)


chessBoard : Model -> Html Msg
chessBoard model =
    case model.position of
        Just position ->
            let
                tiles =
                    List.indexedMap (tile model) position

                chessBoardStyles =
                    [ margin "auto"
                    , padding "50px"
                    , display "grid"
                    , gridTemplateRows "repeat(8, 1fr)"
                    , gridTemplateColumns "repeat(8, 1fr)"
                    , height "800px"
                    , width "800px"
                    , borderRadius "5px"
                    , overflow "hidden"
                    ]
            in
            div chessBoardStyles tiles

        Nothing ->
            div []
                [ button
                    [ Html.Events.onClick (LoadFEN (parseFen startingFEN))
                    ]
                    [ text "Load Game" ]
                ]
