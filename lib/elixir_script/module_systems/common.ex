defmodule ElixirScript.ModuleSystems.Common do
  @moduledoc false  
  alias ESTree.Tools.Builder, as: JS
  alias ElixirScript.Translator

  def import_namespace_module(module_name, from, env) do
    do_import_module(Translator.translate!(module_name, env), from)
  end

  def import_module(module_name, from, env) do
    do_import_module(Translator.translate!(module_name, env), from)
  end

  def import_module(import_name, from) do
    do_import_module(JS.identifier(import_name), from)
  end

  defp do_import_module(ref, file_path) do

    ref_declarator = JS.variable_declarator(
      ref,
      JS.call_expression(
        JS.identifier("require"),
        [JS.literal(file_path)]
      )
    )

    JS.variable_declaration([ref_declarator], :const)

  end

  def export_module(exported_object) do
    JS.assignment_expression(
      :=,
      JS.member_expression(
        JS.identifier("module"),
        JS.identifier("exports")
      ),
      exported_object
    )
  end


end
