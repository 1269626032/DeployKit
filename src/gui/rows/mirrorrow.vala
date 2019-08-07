namespace Dk {

/**
 * Template widget for use in the "Mirrors" section of recipe.
 */
[GtkTemplate (ui = "/io/aosc/DeployKit/ui/dk-mirrorrow.ui")]
public class MirrorRow: Gtk.Box {
  /**
   * Icon identifying the mirror.
   */
  [GtkChild]
  private Gtk.Image icon;

  /**
   * Name of the mirror.
   */
  [GtkChild (name = "name")]
  private Gtk.Label mirror_name;

  /**
   * Location of the mirror.
   */
  [GtkChild]
  private Gtk.Label location;

  /**
   * Constructor for ``Dk.MirrorRow``.
   *
   * @param icon_name   Name of the icon to display.
   * @param mirror_name Name of the mirror (e.g. "LUG@USTC").
   * @param location    Location of the mirror (e.g. "Hefei, Anhui, China").
   */
  public MirrorRow(string icon_name, string mirror_name, string location) {
    this.icon.set_from_icon_name(icon_name, Gtk.IconSize.DIALOG); // 48px
    this.mirror_name.set_text(mirror_name);
    this.location.set_text(location);
  }
}

} /* namespace Dk */
