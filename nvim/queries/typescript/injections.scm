  (call_expression
    function: (member_expression
      object: ((identifier) @_obj (#eq? @_obj "Prisma"))
      property: ((property_identifier) @_prop (#eq? @_prop "sql")))
    arguments: (template_string
      (string_fragment) @injection.content)
    (#set! injection.language "sql"))
