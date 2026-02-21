on run
    set flagFile to (POSIX path of (path to home folder)) & ".claude/sounds-paused"
    try
        do shell script "test -f " & quoted form of flagFile
        -- File exists, sounds are paused — resume them
        do shell script "rm " & quoted form of flagFile
        display alert "🔊 Claude Sounds resumed" giving up after 2
    on error
        -- File doesn't exist, sounds are on — pause them
        do shell script "touch " & quoted form of flagFile
        display alert "🔇 Claude Sounds paused" giving up after 2
    end try
end run
