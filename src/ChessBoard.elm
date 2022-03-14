module ChessBoard exposing (..)

import Css
import FEN exposing (..)
import Html.Styled as Html exposing (..)
import Html.Styled.Attributes as Attr
import List
import Model exposing (GameState, Msg(..))
import Styles exposing (..)
import Tailwind.Utilities as Tw
import Tile exposing (..)


chessBoard : GameState -> Html Msg
chessBoard gameState =
    let
        tiles =
            List.indexedMap (tile gameState) gameState.position
    in
    tiles
        |> Html.div
            [ Attr.css
                [ Tw.m_auto
                , Tw.grid
                , Tw.grid_cols_8
                , Tw.grid_rows_6
                , Css.width (Css.px 800)
                , Css.height (Css.px 800)
                , Tw.rounded
                , Tw.overflow_hidden
                ]
            ]
