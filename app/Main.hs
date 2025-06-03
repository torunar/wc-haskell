module Main (main) where

import Wc
import System.IO
import System.Environment

main :: IO ()
main = do
    (filepath:_) <- getArgs
    handle <- openBinaryFile filepath ReadMode
    (n, w, b) <- Wc.getFileCounts handle 0 0 0
    putStrLn $ (show n) ++ " " ++ (show w) ++ " " ++ (show b) ++ " " ++ filepath
