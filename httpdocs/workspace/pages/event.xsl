<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">



<xsl:import href="../utilities/master.xsl"/>



<xsl:param name="tumblr"/>



<xsl:template match="data">

    <xsl:call-template name="event-profile" />
	
</xsl:template>
</xsl:stylesheet>