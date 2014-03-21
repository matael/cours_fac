function res = savedatmeas(impact,acc)
    [SLm] = vna('get','meas');
    freq = SLm.fdxvec;
    FRF = SLm.xcmeas(1,2).xfer;
    eval(['FRF' num2str(impact) '=FRF;']);
    eval(['save FRF' num2str(impact) ' freq FRF' num2Str(impact)]);
end