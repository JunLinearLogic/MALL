{-# LANGUAGE OverloadedStrings #-}

import Web.Scotty
import qualified Data.Text.Lazy as T
import qualified Data.Text.Lazy.Encoding as T

main :: IO ()
main = scotty 3000 $ do
  -- トップページの表示（GET）
  get "/" $ do
    file "index.html"
  
  -- 論理式を受け取ってチェックする窓口（POST）
  post "/api/check" $ do
    -- 送られてきたデータ（リクエストボディ）を読み込む
    reqBody <- body

    -- 読み込んだデータをHaskellで扱いやすい文字列（Text）に変換
    let formula = T.decodeUtf8 reqBody

    let responseMessage = "【Haskell側で受信成功！】\n"
              <> "入力された式: " <> formula <> "\n\n"
              <> "判定: "
    
    -- 結果をブラウザに返す
    text responseMessage
