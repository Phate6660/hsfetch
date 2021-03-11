import System.Environment.MrEnv (envAsString)

---- Helper functions
--- Remove newline
removeLn :: String -> IO ()
removeLn string = do
    mapM_ putStrLn $ [init] <*> [string]

--- Stripping Chars (used for stripping quotes)
stripChars :: String -> String -> String
stripChars = filter . flip notElem

---- Information gathering functions
--- Get the editor
editor :: IO String
editor = do
    envAsString "EDITOR" "N/A ($EDITOR is not set)"

--- Get the hostname
hostname :: IO String
hostname = do
    hostname <- readFile "/etc/hostname"
    return (stripChars "\"" hostname)

--- Get the kernel release
kernel :: IO String
kernel = do
    kernel <- readFile "/proc/sys/kernel/osrelease"
    return (stripChars "\"" kernel)

--- Get the shell
shell :: IO String
shell = do
    envAsString "SHELL" "N/A ($SHELL is not set)"

--- Get the user
user :: IO String
user = do
    envAsString "USER" "N/A ($USER is not set)"

main :: IO()
main = do
    --- Gather info
    editor <- editor
    hostname <- hostname
    kernel <- kernel
    shell <- shell
    user <- user
    
    --- Output info
    --Editor
    putStr "Editor   = "
    putStrLn editor

    --Hostname
    putStr "Hostname = "
    removeLn hostname

    -- Kernel
    putStr "Kernel   = "
    removeLn kernel

    -- Shell
    putStr "Shell    = "
    putStrLn shell

    -- User
    putStr "User     = "
    putStrLn user
