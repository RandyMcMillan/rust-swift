#!/bin/bash
# GPG Lock Recovery Script

echo "Cleaning up GPG processes..."
# Kill the specific PID mentioned in your error
kill -9 81453 2>/dev/null

# Kill all standard GPG components
gpgconf --kill all
killall gpg-agent 2>/dev/null

echo "Removing stale lock files in ~/.gnupg..."
# Specifically targeting the keydb lock mentioned in the error
if [ -f ~/.gnupg/pubring.kbx.lock ]; then
    rm -v ~/.gnupg/pubring.kbx.lock
fi

# Remove any other potential locks
find ~/.gnupg -name "*.lock" -exec rm -v {} +

echo "Restarting GPG agent..."
gpg-agent --daemon --use-standard-socket

echo "Testing GPG signing..."
echo "test" | gpg --clearsign --local-user A80B2B4F04E32821

echo "Done. Try your git commit again."
