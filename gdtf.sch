<?xml version="1.0" encoding="UTF-8"?>
<sch:schema
        xmlns:sch="http://purl.oclc.org/dsdl/schematron"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <sch:title>GDTF 1.1 (DIN 15800:2020-07)</sch:title>
    <sch:p>These assertions fill validation holes in the main XSD Schema for GDTF 1.1.</sch:p>

    <!-- Keys -->
    <xsl:key
            name="featureKey"
            match="//GDTF/FixtureType/AttributeDefinitions/FeatureGroups/FeatureGroup/Feature"
            use="concat(../@Name, '.', @Name)" />

    <!-- Patterns -->
    <sch:pattern name="Occurence Constraints">
        <sch:rule context="//GDTF/FixtureType/PhysicalDescriptions/Properties">
            <sch:assert test="count(OperatingTemperature) le 1">Error: More than one OperatingTemperature node.</sch:assert>
            <sch:assert test="count(Weight) le 1">Error: More than one Weight node.</sch:assert>
            <sch:assert test="count(LegHeight) le 1">Error: More than 1 LegHeight node.</sch:assert>
        </sch:rule>
    </sch:pattern>

    <sch:pattern name="Feature References">
        <sch:rule context="//GDTF/FixtureType/AttributeDefinitions/Attributes/Attribute">
            <sch:assert test="key('featureKey', @Feature)">Error: Attribute Node with Name "<xsl:value-of 
            select="@Name" />" references Feature "<xsl:value-of select="@Feature" />" which does not exist.</sch:assert>
        </sch:rule>
    </sch:pattern>

    <sch:pattern name="ModeMaster Reference">
        <sch:rule context="//GDTF/FixtureType/DMXModes/DMXMode/DMXChannels/DMXChannel/LogicalChannel/ChannelFunction/@ModeMaster">
            <!-- This test tries to find the node referenced by ModeMaster. 
            Either a DMXChannel in the same mode (first line) or a ChannelFunction (second line) in the same mode. -->

            <!-- TODO: The default name of ChannelFunction needs to be considered here:
            Default value: Name of attribute and number of channel function. 
            TODO: clarify the meaning of the above sentence in the standard
            Is the number the number of all channelFuntions or just the number within the channelFunctions with this specific
            Attribute? So:

            Dimmer1
            Pan2
            Pan3

            OR

            Dimmer1
            Pan1
            Pan2-->
            <sch:assert test="
            ../../../../DMXChannel[concat(@Geometry, '_', LogicalChannel[1]/@Attribute) eq current()]
            |
            ../../../../DMXChannel/LogicalChannel/ChannelFunction
            [concat(../../@Geometry, '_', ../../LogicalChannel[1]/@Attribute, '.', ../@Attribute, '.', @Name) eq current()]
            ">Error: ChannelFunction "<xsl:value-of select="
                concat(../../../@Geometry, '_', ../../../LogicalChannel[1]/@Attribute, '.', ../../@Attribute, '.', ../@Name)
                " />" in DMXMode "<xsl:value-of select="../../../../../@Name" />" references ModeMaster "<xsl:value-of 
                select="." />" which does not exist in this mode.
            </sch:assert>
        </sch:rule>
    </sch:pattern>

    <sch:pattern name="Unique DMXChannel Name in each DMXMode">
        <sch:rule context="//GDTF/FixtureType/DMXModes/DMXMode/DMXChannels">
            <sch:assert test="
            count(DMXChannel) eq count(distinct-values(DMXChannel/concat(@Geometry, '_', LogicalChannel[1]/@Attribute)))
            ">Error: The DMXMode "<xsl:value-of select="../@Name"
             />" contains multiple DMXChannel nodes with the same name(s) <xsl:for-each select="
                let $seq := DMXChannel/concat(@Geometry, '_', LogicalChannel[1]/@Attribute)
                return $seq[index-of($seq,.)[2]]
                ">"<xsl:value-of select="." />" </xsl:for-each>
            </sch:assert>
        </sch:rule>
    </sch:pattern>

    <sch:pattern name="Unique combination of Attribute and Geometry for each LogicalChannel in a given DMXMode">
        <!-- TODO: reports twice for each duplicate. Would be nicer if it reported once per duplication. -->
        <sch:rule context="//GDTF/FixtureType/DMXModes/DMXMode/DMXChannels/DMXChannel/LogicalChannel">
            <sch:assert test="count(../../DMXChannel/LogicalChannel[@Attribute eq current()/@Attribute and ../@Geometry eq current()/../@Geometry]) eq 1
            ">Error: The DMXMode "<xsl:value-of select="../../../@Name" 
                />" contains multiple LogicalChannels with the Attribute "<xsl:value-of 
                select="@Attribute" />" and the Geometry "<xsl:value-of select="../@Geometry" />".</sch:assert>
        </sch:rule>
    </sch:pattern>

</sch:schema>