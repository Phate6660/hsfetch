---- Helper functions
-- Remove newline
removeLn :: String -> IO ()
removeLn string = do
    mapM_ putStrLn $ [init] <*> [string]

-- Stripping Chars (used for stripping quotes)
stripChars :: String -> String -> String
stripChars = filter . flip notElem

---- Get the hostname
hostname :: IO String
hostname = do
    hostname <- readFile "/etc/hostname"
    return (stripChars "\"" hostname)

---- Get the kernel release
kernel :: IO String
kernel = do
    kernel <- readFile "/proc/sys/kernel/osrelease"
    return (stripChars "\"" kernel)

main :: IO()
main = do
    --- Gather info
    hostname <- hostname
    kernel <- kernel
    
    --- Output info
    --Hostname
    putStr "Hostname = "
    removeLn hostname

    -- Kernel
    putStr "Kernel   = "
    removeLn kernel
