//-----------------------------------------------------------------------------
//----- GDTF Multi-LED Virtual Fixture ----------------------------------------
//-----------------------------------------------------------------------------

/**
 * @brief Structure that hold 4 DMX universes. Currently is holding four universe, but can be enlarged if needed. The DMX Universes don't need to be after each other in memory.
 * 
 */
struct DMX {
    /**
     * @brief DMX universe from first break
     * 
     */
    void* DMX1;
    /**
     * @brief DMX universe from second break
     * 
     */
    void* DMX2;
    /**
     * @brief DMX universe from third break
     * 
     */
    void* DMX3;
    /**
     * @brief DMX universe from fourth break
     * 
     */
    void* DMX4;
};


/**
 * @brief Defines one virtual channel function that is defined by an attribute linking to a kinematic chain. This virtual channel function 
 * may be applied after all other GDTF channel functions are applied to the kinematic chain.
 * 
 * The restriction, that one channel function can only define an attribute once for geometry, does not apply to virtual channel functions.
 * 
 */
struct VirtualChannelFunction {
    /**
     * @brief Name of the Geometry that is referenced from the GDTF file.
     * 
     */
    char*       Geometry;
    /**
     * @brief Defines the attribute that will be modified. Use the ones that are available in GDTF. 
     * 
     */
    char*       Attribute;
    /**
     * @brief Defines the physical value that will be applied to the geometry. Use the Unit defined for the GDTF attribute.
     * 
     */
    double      PhysicalValue;
    /**
     * @brief Defines of on this thick the virtual channel function should be applied.
     * 
     */
    bool        Active;
    /**
     * @brief A pointer that you can attach for convience.
     * 
     */
    void*       Custom;

};

/**
 * @brief Defines the virtual fixture and its functions. 
 * 
 */
struct VirtualFixture {
    /**
     * @brief Array of VirtualChannelFunction
     * 
     */
    VirtualChannelFunction* Functions;
    /**
     * @brief Count of VirtualChannelFunctions in  Functions
     * 
     */
    size_t                  CountFunctions;           
};

const size_t kOk        = 0;
const size_t kWrongMode = 1;

/**
 * @brief Initialize a virtual fixture. You need one virtual function for each fixture of one mode and type that gets differnt DMX send.
 * 
 * @param fixture The virtual fixture to initialize
 * @param mode The mode that is used
 * @return kOk when call successful, kWrongMode when mode is wrong
 * 
 */
size_t fixture_initialize(VirtualFixture& fixture, char* mode)
{
    size_t i = 0;
    fixture.functions = new Functions[25]();
    fixture.functions[i++].push_back({"base.yoke.head.geometryref1.lamp1","Dimmer"});
    fixture.functions[i++].push_back({"base.yoke.head.geometryref1.lamp1","ColorAdd_R"});
    fixture.functions[i++].push_back({"base.yoke.head.geometryref1.lamp1","ColorAdd_G"});
    fixture.functions[i++].push_back({"base.yoke.head.geometryref1.lamp1","ColorAdd_B"});
    fixture.functions[i++].push_back({"base.yoke.head.geometryref2.lamp1","Dimmer"});
    fixture.functions[i++].push_back({"base.yoke.head.geometryref2.lamp1","ColorAdd_R"});
    fixture.functions[i++].push_back({"base.yoke.head.geometryref2.lamp1","ColorAdd_G"});
    fixture.functions[i++].push_back({"base.yoke.head.geometryref2.lamp1","ColorAdd_B"});
    fixture.functions[i++].push_back({"base.yoke.head.geometryref3.lamp1","Dimmer"});
    fixture.functions[i++].push_back({"base.yoke.head.geometryref3.lamp1","ColorAdd_R"});
    fixture.functions[i++].push_back({"base.yoke.head.geometryref3.lamp1","ColorAdd_G"});
    fixture.functions[i++].push_back({"base.yoke.head.geometryref3.lamp1","ColorAdd_B"});
    fixture.functions[i++].push_back({"base.yoke.head.geometryref4.lamp1","Dimmer"});
    fixture.functions[i++].push_back({"base.yoke.head.geometryref4.lamp1","ColorAdd_R"});
    fixture.functions[i++].push_back({"base.yoke.head.geometryref4.lamp1","ColorAdd_G"});
    fixture.functions[i++].push_back({"base.yoke.head.geometryref4.lamp1","ColorAdd_B"});
    fixture.functions[i++].push_back({"base.yoke.head.geometryref5.lamp1","Dimmer"});
    fixture.functions[i++].push_back({"base.yoke.head.geometryref5.lamp1","ColorAdd_R"});
    fixture.functions[i++].push_back({"base.yoke.head.geometryref5.lamp1","ColorAdd_G"});
    fixture.functions[i++].push_back({"base.yoke.head.geometryref5.lamp1","ColorAdd_B"});
    fixture.functions[i++].push_back({"base.yoke.head.geometryref6.lamp1","Dimmer"});
    fixture.functions[i++].push_back({"base.yoke.head.geometryref6.lamp1","ColorAdd_R"});
    fixture.functions[i++].push_back({"base.yoke.head.geometryref6.lamp1","ColorAdd_G"});
    fixture.functions[i++].push_back({"base.yoke.head.geometryref6.lamp1","ColorAdd_B"});
    fixture.functions[i++].push_back({"base.yoke.head.geometryref7.lamp1","Dimmer"});
    fixture.functions[i++].push_back({"base.yoke.head.geometryref7.lamp1","ColorAdd_R"});
    fixture.functions[i++].push_back({"base.yoke.head.geometryref7.lamp1","ColorAdd_G"});
    fixture.functions[i++].push_back({"base.yoke.head.geometryref7.lamp1","ColorAdd_B"});
    fixture.functions[i++].push_back({"base.yoke.head.geometryref8.lamp1","Dimmer"});
    fixture.functions[i++].push_back({"base.yoke.head.geometryref8.lamp1","ColorAdd_R"});
    fixture.functions[i++].push_back({"base.yoke.head.geometryref8.lamp1","ColorAdd_G"});
    fixture.functions[i++].push_back({"base.yoke.head.geometryref8.lamp1","ColorAdd_B"});
    fixture.functions[i++].push_back({"base.yoke.head.geometryref9.lamp1","Dimmer"});
    fixture.functions[i++].push_back({"base.yoke.head.geometryref9.lamp1","ColorAdd_R"});
    fixture.functions[i++].push_back({"base.yoke.head.geometryref9.lamp1","ColorAdd_G"});
    fixture.functions[i++].push_back({"base.yoke.head.geometryref9.lamp1","ColorAdd_B"});

    return kOk;
}

/**
 * @brief Calculates the values of virtual channel function for a given timestamp.
 * 
 * @param timepoint_ms The current time in miliseconds
 * @param dmx1 The DMX data buffer
 * @param fixture The virtual fixture that is calculated
 * 
 */
void main_function(uint32_t timepoint_ms, DMX* dmx1, VirtualFixture& fixture)
{
    for (size_t i = 0; i < 25; i++)
    {
        fixture.functions[i].Percent = dmx1->DMX1[i] * timepoint_ms * i;
        fixture.functions[i].Active  = (timepoint_ms % 2 == 0);
    }
    
}

/**
 * @brief Deinitializes the fixture.
 * 
 * @param fixture The fixture that you don't use anymore
 * 
 */
void fixture_deinitialize(VirtualFixture& fixture)
{
    for (size_t i = 0; i < 25; i++)
    {
        delete [] fixture.functions[i];
    }
}