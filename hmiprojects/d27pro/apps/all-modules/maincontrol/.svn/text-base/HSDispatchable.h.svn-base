#pragma once

class HSControl;
class HSDispatchable
{
public:
    using SignalId = void (HSControl::*)();
    virtual void dispatch(SignalId signal) = 0;
};
