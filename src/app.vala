namespace Dk {
  /**
   * Main application manager of DeployKit.
   */
  public class App : Gtk.Application {
    private static bool version = false;

    private const GLib.OptionEntry[] options = {
      {"version", 'v', GLib.OptionFlags.NONE, GLib.OptionArg.NONE, ref version, "Show version information", null},
    };

    /**
     * Constructor of the application.
     *
     * This creates a ``Gtk.Application`` with project-defined attributes.
     */
    public App() {
      Object(
        application_id: "io.aosc.DeployKit",
        flags: GLib.ApplicationFlags.HANDLES_OPEN
      );

      this.set_option_context_summary("AOSC OS Installer and Recovery Utility");
      this.add_main_option_entries(this.options);
    }

    /**
     * Signal handler for the ``handle_local_options`` signal of application.
     *
     * This is called when some command line arguments are parsed.
     *
     * @param options Command line arguments get parsed by ``GApplication``.
     * @return Any positive exit code if the handler want to quit the program
     *         with it, otherwise -1 to let ``GApplication`` continue running
     *         the application.
     */
    protected override int handle_local_options(GLib.VariantDict options) {
      if (this.version) {
        stdout.printf("%s\n", Dk.get_version());
        return 0;
      }

      return -1;
    }

    /**
     * Signal handler for the ``activate`` signal of application.
     *
     * This is called when the program is started.
     */
    protected override void activate() {
      var guimain = new Dk.GuiMain();

      string? env_root_url = GLib.Environ.get_variable(GLib.Environ.get(), "DK_ROOT_URL");
      if (env_root_url != null)
        guimain.set_root_url(env_root_url);

      this.add_window(guimain);
      guimain.show_all();
    }

    /**
     * Signal handler for the ``open`` signal of application.
     *
     * This is called when the program is started with a list of file appended
     * in the command line. The appended file is expected to be a
     * ``recipe.json`` file as specified in the corresponding specification in
     * documentation.
     *
     * @param files A list of files.
     * @param hint  A hint (?).
     */
    protected override void open(GLib.File[] files, string hint) {
      var guimain = new Dk.GuiMain();

      if (files.length > 1)
        GLib.message("more than one local recipe are given, only the first one will be processed.");

      guimain.set_local_recipe(files[0]);

      this.add_window(guimain);
      guimain.show_all();
    }
  }
}