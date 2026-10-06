<?xml version="1.0"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:core="http://www.gtk.org/introspection/core/1.0"
	xmlns:c="http://www.gtk.org/introspection/c/1.0"
	xmlns:glib="http://www.gtk.org/introspection/glib/1.0"
	version="1.0">

  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="core:package/@name">
    <xsl:attribute name="name">libnautilus-extension-4</xsl:attribute>
  </xsl:template>

  <!-- Nautilus calls get_file_items with a null list whenever nothing is
       selected, which is every time a folder is opened, but the GIR does not
       mark the list as nullable. An implementation taking it as non-null
       dereferences null and takes Nautilus down. -->
  <xsl:template match="core:interface[@name='MenuProvider']/core:virtual-method[@name='get_file_items']/core:parameters/core:parameter[@name='files'] |
                       core:interface[@name='MenuProvider']/core:method[@name='get_file_items']/core:parameters/core:parameter[@name='files'] |
                       core:record[@name='MenuProviderInterface']/core:field[@name='get_file_items']/core:callback/core:parameters/core:parameter[@name='files']">
    <xsl:copy>
      <xsl:attribute name="nullable">1</xsl:attribute>
      <xsl:copy-of select="@* | node()"/>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
