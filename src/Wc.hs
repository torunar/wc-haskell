module Wc
    ( getFileCounts
    ) where
    
import System.IO
import qualified Data.ByteString as BS
import qualified Data.ByteString.Char8 as BS8

 -- \0 at the end of the line is a byte, too
countBytes :: BS.ByteString -> Int
countBytes s = BS.length s + 1

countWords :: BS.ByteString -> Int
countWords s = length (BS8.words s)

getFileCounts :: Handle -> Int -> Int -> Int -> IO (Int, Int, Int)
getFileCounts fileHandle newlineCount wordCount byteCount = do
    eof <- hIsEOF fileHandle
    if eof then 
        return (newlineCount, wordCount, byteCount)
    else do
        line <- BS8.hGetLine fileHandle
        getFileCounts
            fileHandle
            (newlineCount + 1)
            (wordCount + countWords line)
            (byteCount + countBytes line)
