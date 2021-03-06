{-# LANGUAGE TemplateHaskell #-}
module View.Template (module View.Template) where

import Text.Hamlet       ( shamletFile
                         , Html              )
import Text.Lucius       ( luciusFile
                         , renderCss
                         , Css               )
import Text.Julius       ( juliusFile
                         , renderJavascriptUrl
                         , Javascript        )
import Text.Blaze.Html   ( preEscapedToHtml  )

import View.TemplateUtil ( hamFile
                         , cssFile
                         , jsFile            )

mainStyleSheet = renderCss $ $(luciusFile (cssFile "styles")) undefined

mainJS = renderJavascriptUrl (\_ _ -> undefined) $(juliusFile (jsFile "main"))

homePageT :: Html
homePageT = $(shamletFile $ hamFile "home")

footerT :: Html
footerT = $(shamletFile $ hamFile "footer")

headerT :: Html
headerT = $(shamletFile $ hamFile "header")
