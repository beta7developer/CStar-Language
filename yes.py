import time
import signal
import sys

def signal_handler(sig, frame):
    print("\n")  # Print newline when Ctrl+C is pressed
    # Don't exit, just return to allow the loop to continue

def yes():
    # Set up signal handler for Ctrl+C
    signal.signal(signal.SIGINT, signal_handler)
    
    try:
        while True:
            print("y")
    except KeyboardInterrupt:
        print("\n")
        return  # Return instead of exiting
    
if __name__ == "__main__":
    yes()