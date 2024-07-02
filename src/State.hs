module State (FileState (FileState), State (State), emptyState, initState, setFileState, getFileStateByUri, setImpState, getImpState) where

import Data.Map qualified as Map
import ImplicitsScope
import ScopeAnalysis
import Language.LSP.Protocol.Types (Uri, uriToFilePath, Range)
import Language.LSP.VFS (VirtualFile)
import System.Environment (lookupEnv)
import Agda.Syntax.Concrete (Module)
import ScopeImport qualified as Imp

data FileState = FileState VirtualFile (Either (Range, String) Module) ImplicitsScope ScanState

data State = State (Map.Map FilePath FileState) Imp.State

emptyState :: State
emptyState = State Map.empty Imp.emptyState

initState :: IO State
initState = do
  var <- lookupEnv "AGDA_LIBRARIES_FILE"
  pure $ case var of
    (Just path) ->
      let impState = Imp.setLibrariesFile path Imp.emptyState
      in setImpState emptyState impState
    Nothing -> emptyState

setFileState :: State -> FilePath -> Maybe FileState -> State
setFileState (State mp x) path Nothing = State (Map.delete path mp) x
setFileState (State mp x) path (Just v) = State (Map.insert path v mp) x

getFileStateByUri :: State -> Uri -> Maybe FileState
getFileStateByUri (State mp _) fileUri = case uriToFilePath fileUri of
  Just filePath -> Map.lookup filePath mp
  Nothing -> Nothing

setImpState :: State -> Imp.State -> State
setImpState (State mp _) = State mp

getImpState :: State -> Imp.State
getImpState (State _ x)  = x
