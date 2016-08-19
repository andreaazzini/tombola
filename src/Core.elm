module Core exposing (Model, Msg(Extract, Stop), init, update, subscriptions)

import Random exposing (Seed)
import Result
import String
import WebSocket

import Utils


-- MODEL

type alias Model =
  { numbers : List Int
  }

init : (Model, Cmd Msg)
init =
  (Model [1..90], Cmd.none)


-- UPDATE

type Msg
  = Extract
  | Pop Int
  | NewMessage String
  | Stop

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Extract ->
      (model, Random.generate Pop (Random.int 0 (List.length model.numbers - 1)))

    Pop index ->
      (model, WebSocket.send "ws://localhost:4080" (Utils.at model.numbers index |> toString))

    NewMessage received ->
      (interpretMessage received model, Cmd.none)

    Stop ->
      (Model [1..90], WebSocket.send "ws://localhost:4080" "stop")

interpretMessage : String -> Model -> Model
interpretMessage msg model =
  let intMsg = Result.withDefault 0 (String.toInt msg)
  in if intMsg == 0 then
    Model [1..90]
  else
    Model (List.filter (\elem -> elem /= intMsg) model.numbers)


-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  WebSocket.listen "ws://localhost:4080" NewMessage
