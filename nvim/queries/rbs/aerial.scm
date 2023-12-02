(class_decl
  (class_name (constant) @name)
  (#set! "kind" "Class")
  ) @symbol

(module_decl
  (module_name (constant) @name)
  (#set! "kind" "Module")
  ) @symbol

(const_decl
  (const_name) @name
  (#set! "kind" "Constant")
  ) @symbol

(global_decl
  (global_name) @name
  (#set! "kind" "Variable")
  ) @symbol

(interface_decl
  (interface_name (interface) @name)
  (#set! "kind" "Interface")
  ) @symbol

(method_member
  ((visibility) @scope)?
  (method_name (identifier) @name)
  (#set! "kind" "Method")
  ) @symbol

(ivar_member
  [(ivar_name) (cvar_name)] @name
  (#set! "kind" "Property")
  ) @symbol

(attribute_member
  ((visibility) @scope)?
  (method_name (identifier) @name)
  (#set! "kind" "Method")
  ) @symbol
