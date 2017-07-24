{-# LANGUAGE ScopedTypeVariables #-}

module View.Views
    ( homePage
    , serveCSS
    , serveJS
    ) where

import View.ContentTypes ( toResMime
                         , MIMEType (JS, CSS, HTML)
                         )

import Happstack.Server ( notFound
                        , nullDir
                        , ok
                        , path
                        , toResponse
                        , ServerPart
                        , ToMessage
                        , Response  )

import qualified View.Template as Template

serveCSS :: ServerPart Response
serveCSS = path $ \(cssRequest :: String) ->
                case cssRequest of
                    "styles.css" -> nullDirServe Template.mainStyleSheet CSS
                    _            -> notFound $ toResponse ("CSS stylesheet not found." :: String)

serveJS :: ServerPart Response
serveJS = path $ \(jsRequest :: String) ->
             case jsRequest of
                "main.js"    -> nullDirServe Template.mainJS JS
                _            -> notFound $ toResponse ("JavaScript file not fouund." :: String)


-- |Make sure the request is sane (no path segments after *.css or *.js or
--  whatever); if so, serve the file with a MIME type, like "text/css"
nullDirServe :: (ToMessage t) => t -> MIMEType -> ServerPart Response
nullDirServe template mimeT = nullDir >> ok (toResMime template mimeT)

homePage :: ServerPart Response
homePage = ok $ toResponse Template.homePageT
