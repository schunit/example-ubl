<?xml version="1.0" encoding="UTF-8"?>
<!-- 

This is a Schematron implementation of additional document constraints defined by UBL 2.2.

http://docs.oasis-open.org/ubl/os-UBL-2.2/UBL-2.2.html#S-ADDITIONAL-DOCUMENT-CONSTRAINTS

List of constraints not possible to implement using Schematron:
* [IND1] All UBL instance documents MUST validate to a corresponding schema.
* [IND2] All UBL instance documents MUST identify their character encoding within the XML declaration.
* [IND3] In conformance with ISO IEC ITU UN/CEFACT eBusiness Memorandum of Understanding Management Group (MOUMG) 
  Resolution 01/08 (MOU/MG01n83) as agreed to by OASIS, all UBL XML SHOULD be expressed using UTF-8.
* [IND6] The absence of a construct or data in a UBL instance document MUST NOT carry meaning.

-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" schemaVersion="iso" queryBinding="xslt2">

    <title>UBL 2.2 Document Constrains</title>

    <ns prefix="cac" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"/>
    <ns prefix="cbc" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"/>
    <ns prefix="ext" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2"/>
    <ns prefix="sac" uri="urn:oasis:names:specification:ubl:schema:xsd:SignatureAggregateComponents-2"/>
    <ns prefix="sbc" uri="urn:oasis:names:specification:ubl:schema:xsd:SignatureBasicComponents-2"/>

    <pattern>
        <!-- Normal rules does not apply to ext:ExtensionContent. -->
        <rule context="ext:ExtensionContent"/>

        <!-- Validation of aggregate components. -->
        <rule context="cac:* | sac:* | ext:UBLExtension | ext:UBLExtensions">
            <assert id="IND5-1" test="cac:* | cbc:* | sac:* | sbc:*">UBL conformant instance documents MUST NOT contain an element devoid of content or containing null values, except in the case of extension, where the UBL ExtensionContent element is used.</assert>
        </rule>

        <!-- Validation of basic components. -->
        <rule context="cbc:* | sbc:* | ext:*">
            <assert id="IND5-2" test="normalize-space() != ''">UBL conformant instance documents MUST NOT contain an element devoid of content or containing null values, except in the case of extension, where the UBL ExtensionContent element is used.</assert>
            <!-- This is listed as "IND7" in 2.2, however it is supposed to be "IND9" as fixed in 2.3. -->
            <assert id="IND9" test="every $attr in @* satisfies normalize-space($attr) != ''">UBL-conforming instance documents MUST NOT contain an attribute devoid of content or containing null values.</assert>
        </rule>
    </pattern>

    <pattern>
        <!--
        [IND7] Where two or more sibling “Text. Type” elements of the same name exist in a document, no two can have the same “languageID” attribute value.
        [IND8] Where two or more sibling “Text. Type” elements of the same name exist in a document, no two can omit the “languageID” attribute.
        -->
        <!-- <rule context="cbc:*Text | sbc:*Text | ext:*Text">

        </rule> -->
    </pattern>

</schema>