function yawPitchRoll = quaternionToEuler(quat)
%QUATERNIONTOEULER Converts quaternios to Euler angles in the Yaw, Pitch,
%Roll order
%   The input, quat is a nx4 matrix which contains the quaternions
%   in the following order: qx, qy, qz, qw. n is an arbitrary number of
%   sets of quaternions.
%   
%   The output, yawPitchRoll is a nx3 matrix which contains the
%   corresponding Euler angles for each set of the quaternions. The order
%   of the angles is: Yaw, Ptich, Roll. These angles are in degrees.
%

    [x y] = size(quat);
    numOfElements = x;
    clear x y;

    yawPitchRoll = zeros(numOfElements,3);

    for i = 1:numOfElements
        
        % extracting data
        qx = quat(i,1);   % e1
        qy = quat(i,2);   % e2
        qz = quat(i,3);   % e3
        qw = quat(i,4);   % e0
        
        % computing stuff needed
        l1 = qw^2 + qx^2 - qy^2 - qz^2;
        l2 = 2*(qx*qy + qw*qz);
        l3 = 2*(qx*qz - qw*qy);

        n3 = qw^2 - qx^2 - qy^2 + qz^2;
        m3 = 2*(qy*qz + qw*qx);

        % in radians
        theta   = asin(-l3);                    % Pitch
        psi     = acos(l1/cos(theta))*sign(l2); % Yaw (Azimuth)
        if(~isreal(psi))
            psi = real(psi); % since imaginary is super small
        end
        phi     = acos(n3/cos(theta))*sign(m3); % Roll (Bank)
        if(~isreal(phi))
            phi = real(phi); % since imaginary is super small
        end
        
        % storing in output matrix
        yawPitchRoll(i,:) = [radtodeg(psi) radtodeg(theta) radtodeg(phi)];

    end

end



