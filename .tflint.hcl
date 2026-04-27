config {
  format          = "default"
  call_module_type = "local"
}

plugin "terraform" {
  enabled = true
  preset  = "recommended"
}

rule "terraform_required_version"    { enabled = true }
rule "terraform_required_providers"  { enabled = true }
rule "terraform_typed_variables"     { enabled = true }
rule "terraform_documented_variables" { enabled = true }
rule "terraform_documented_outputs"  { enabled = true }
rule "terraform_unused_declarations" { enabled = true }
rule "terraform_naming_convention"   { enabled = true }
rule "terraform_module_pinned_source" { enabled = true }
rule "terraform_module_version"      { enabled = true }
rule "terraform_deprecated_index"    { enabled = true }
rule "terraform_deprecated_interpolation" { enabled = true }
rule "terraform_empty_list_equality" { enabled = true }
rule "terraform_unused_required_providers" { enabled = true }
