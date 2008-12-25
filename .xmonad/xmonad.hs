{- xmonad.hs
 - Author: Øyvind 'Mr.Elendig' Heggstad <mrelendig AT har-ikkje DOT net>
 - Version: 0.0.9
 -}

-------------------------------------------------------------------------------
-- Imports --
-- stuff
import XMonad
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import System.Exit
import Graphics.X11.Xlib
import IO (Handle, hPutStrLn) 

-- utils
import XMonad.Util.Run (spawnPipe)

-- hooks
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog

-- layouts
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile

-------------------------------------------------------------------------------
-- Main --
main = do
       h <- spawnPipe "xmobar"
       xmonad $ defaultConfig 
              { workspaces = workspaces'
              , modMask = modMask'
              , borderWidth = borderWidth'
              , normalBorderColor = normalBorderColor'
              , focusedBorderColor = focusedBorderColor'
              , terminal = terminal'
              , keys = keys'
              , logHook = logHook' h 
              , layoutHook = layoutHook'
              , manageHook = manageHook'
              }

-------------------------------------------------------------------------------
-- Hooks --
manageHook' :: ManageHook
manageHook' = (doF W.swapDown) <+> manageHook defaultConfig <+> manageDocks

logHook' :: Handle ->  X ()
logHook' h = dynamicLogWithPP $ customPP { ppOutput = hPutStrLn h }

layoutHook' = customLayout

-------------------------------------------------------------------------------
-- Looks --
-- bar
customPP :: PP
customPP = defaultPP { ppCurrent = xmobarColor "#AFAF87" "" . wrap "<" ">"
                     , ppTitle =  shorten 80
                     , ppSep =  "<fc=#AFAF87> | </fc>"
                     , ppHiddenNoWindows = xmobarColor "#AFAF87" ""
                     , ppUrgent = xmobarColor "#FFFFAF" "" . wrap "[" "]"
                     }

-- borders
borderWidth' :: Dimension
borderWidth' = 1

normalBorderColor', focusedBorderColor' :: String
normalBorderColor'  = "#333333"
focusedBorderColor' = "#AFAF87"

-- workspaces
workspaces' :: [WorkspaceId]
workspaces' = ["1-main", "2-web", "3-mail", "4-torrents", "5-im", "6", "7", "8", "9"]

-- layouts
customLayout = avoidStruts $ smartBorders tiled ||| smartBorders (Mirror tiled)  ||| noBorders Full
  where
    tiled = ResizableTall 1 (2/100) (1/2) []

-------------------------------------------------------------------------------
-- Terminal --
terminal' :: String
terminal' = "urxvt"

-------------------------------------------------------------------------------
-- Keys/Button bindings --
-- modmask
modMask' :: KeyMask
modMask' = mod4Mask

-- keys
keys' :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
keys' conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
    -- launching and killing programs
    [ ((modMask,               xK_Return), spawn $ XMonad.terminal conf) 
    , ((modMask,               xK_p     ), spawn "exe=`dmenu_path | dmenu` && eval \"exec $exe\"") 
    , ((modMask .|. shiftMask, xK_p     ), spawn "gmrun")
    , ((modMask .|. shiftMask, xK_c     ), kill)
    , ((modMask .|. shiftMask, xK_m     ), spawn "claws-mail")

    -- layouts
    , ((modMask,               xK_space ), sendMessage NextLayout)
    , ((modMask .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
    , ((modMask,               xK_b     ), sendMessage ToggleStruts)

    -- floating layer stuff
    , ((modMask,               xK_t     ), withFocused $ windows . W.sink)

    -- refresh
    , ((modMask,               xK_n     ), refresh)

    -- focus
    , ((modMask,               xK_Tab   ), windows W.focusDown)
    , ((modMask,               xK_j     ), windows W.focusDown)
    , ((modMask,               xK_k     ), windows W.focusUp)
    , ((modMask,               xK_m     ), windows W.focusMaster)

    -- swapping
    , ((modMask .|. shiftMask, xK_Return), windows W.swapMaster)
    , ((modMask .|. shiftMask, xK_j     ), windows W.swapDown  )
    , ((modMask .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- increase or decrease number of windows in the master area
    , ((modMask              , xK_comma ), sendMessage (IncMasterN 1))
    , ((modMask              , xK_period), sendMessage (IncMasterN (-1)))

    -- resizing
    , ((modMask,               xK_h     ), sendMessage Shrink)
    , ((modMask,               xK_l     ), sendMessage Expand)
    , ((modMask .|. shiftMask, xK_h     ), sendMessage MirrorShrink)
    , ((modMask .|. shiftMask, xK_l     ), sendMessage MirrorExpand)

    -- mpd controls
    , ((modMask .|. controlMask,  xK_h     ), spawn "mpc prev")
    , ((modMask .|. controlMask,  xK_t     ), spawn "mpc pause")
    , ((modMask .|. controlMask,  xK_n     ), spawn "mpc play")
    , ((modMask .|. controlMask,  xK_s     ), spawn "mpc next")
    , ((modMask .|. controlMask,  xK_g     ), spawn "mpc seek -2%")
    , ((modMask .|. controlMask,  xK_c     ), spawn "mpc volume -4")
    , ((modMask .|. controlMask,  xK_r     ), spawn "mpc volume +4")
    , ((modMask .|. controlMask,  xK_l     ), spawn "mpc seek +2%")

    -- quit, or restart
    , ((modMask .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))
    , ((modMask              , xK_q     ), restart "xmonad" True)
    ]
    ++
    -- mod-[1..9] %! Switch to workspace N
    -- mod-shift-[1..9] %! Move client to workspace N
    [((m .|. modMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

-------------------------------------------------------------------------------
