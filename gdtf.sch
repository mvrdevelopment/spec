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
            <!-- This test tries to find the node referenced by ModeMaster, 
            either a DMXChannel or a ChannelFunction in the same mode. -->
            <sch:assert test="
            ../../../../DMXChannel[concat(@Geometry, '_', LogicalChannel[1]/@Attribute) eq current()]
            |
            ../../../../DMXChannel/LogicalChannel/ChannelFunction
            [
                let $channelFunctionName := if(not(@Name)) then(concat(@Attribute, ' ', position())) else(@Name)
                return concat(
                    ../../@Geometry, '_', ../../LogicalChannel[1]/@Attribute, '.', ../@Attribute, '.', $channelFunctionName
                ) eq current()
            ]
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
            <sch:assert test="count(
                ../../DMXChannel/LogicalChannel[@Attribute eq current()/@Attribute and ../@Geometry eq current()/../@Geometry]
                ) eq 1
            ">Error: The DMXMode "<xsl:value-of select="../../../@Name" 
                />" contains multiple LogicalChannels with the Attribute "<xsl:value-of 
                select="@Attribute" />" and the Geometry "<xsl:value-of select="../@Geometry" />".</sch:assert>
        </sch:rule>
    </sch:pattern>

    <sch:pattern name="No Conflict between Default ChannelFunction Name and other ChannelFunction Names in a given LogicalChannel">
        <sch:rule context="//GDTF/FixtureType/DMXModes/DMXMode/DMXChannels/DMXChannel/LogicalChannel/ChannelFunction[not(@Name)]">
            <sch:assert test="
                let $defaultChannelFunctionName := concat(@Attribute, ' ', count(preceding-sibling::ChannelFunction)+1)
                return count(../ChannelFunction[@Name eq $defaultChannelFunctionName]) eq 0
            ">Error: In DMX Mode "<xsl:value-of select="../../../../@Name"/>", the Name of Channel Function "<xsl:value-of 
            select="concat(
                ../../@Geometry, '_', ../../LogicalChannel[1]/@Attribute, '.', ../@Attribute, '.', concat(@Attribute, ' ', 
                count(preceding-sibling::ChannelFunction)+1)
            )"/>" conincides with the default Name of Channel Function Number <xsl:value-of select="
            count(preceding-sibling::ChannelFunction)+1" /> in the Logical Channel "<xsl:value-of select="
            concat(../../@Geometry, '_', ../../LogicalChannel[1]/@Attribute, '.', ../@Attribute)"/>".</sch:assert>
        </sch:rule>
    </sch:pattern>

</sch:schema>