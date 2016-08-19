import Core exposing (Model, Msg, init, update, subscriptions)
import Html exposing (Html, button, div, text)
import Html.App as App
import Html.Events exposing (onClick)

import Utils


main =
  App.program
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view
    }


-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ div [] [ text (toString (Utils.selectedNumbers model.numbers)) ]
    ]
