// This will run into an out-of-memory error when `yes | tr -d \\n` is piped into it.
// Also, it can't work with partial lines.
shared void run2() {
    while(exists l = process.readLine()){
        print(l);
    }
}