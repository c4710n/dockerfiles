#!/bin/sh

if [[ $CONFIG_VARS ]]; then
    CONFIG_OBJ=${CONFIG_OBJ:="window.__env"}

    SPLIT=$(echo $CONFIG_VARS | tr "," "\n")
    ARGS=
    for VAR in ${SPLIT}; do
        ARGS="${ARGS} -v ${VAR} "
    done

    JSON=`json_env --json $ARGS`

    JS="${CONFIG_OBJ} = ${JSON}"
    echo "> Writing ${CONFIG_FILE} with '${JS}'"
    echo "${JS}" > ${CONFIG_FILE}
fi

exec "$@"
