#!/bin/bash

main() {
    OUTPUT=$(brew install --build-from-source --formula Formula/lacework-cli.rb 2>&1)
    if [[ "$OUTPUT" == *"Warning"* ]] ; then
        printf "Output contains warning: %s \n ${OUTPUT}"
        exit 1
    fi

    echo $OUTPUT
}

main "$@"