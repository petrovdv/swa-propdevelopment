#!/usr/bin/env bash

INPUT_FILE="audit.log"
OUTPUT_FILE="audit-extract.log"

jq -c '
  select(

    # 1. get secrets
    (
      .objectRef?.resource == "secrets"
      and .verb == "get"
    )

    or

    # 2. exec в контейнер
    (
      .verb == "create"
      and .objectRef?.subresource == "exec"
    )

    or

    # 3. privileged pod
    (
      .objectRef?.resource == "pods"
      and (
        .requestObject?.spec?.containers[]?
        .securityContext?.privileged == true
      )
    )

    or

    # 4. RoleBinding / ClusterRoleBinding с cluster-admin
    (
      .verb == "create"
      and (
        .objectRef?.resource == "rolebindings"
        or
        .objectRef?.resource == "clusterrolebindings"
      )
      and .requestObject?.roleRef?.name == "cluster-admin"
    )
  )
' "$INPUT_FILE" > "$OUTPUT_FILE"

# 5. audit-policy строки
grep -i 'audit-policy' "$INPUT_FILE" >> "$OUTPUT_FILE"

# удаляем дубликаты
sort -u "$OUTPUT_FILE" -o "$OUTPUT_FILE"

echo "Фильтрация завершена. Результат записан в $OUTPUT_FILE"