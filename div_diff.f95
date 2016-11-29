        ! Author: Julian Prye
        ! Purpose: To use the divided difference algorithm to find a
        ! polynomial approximation of a series of points in cartesian
        ! space.

        module div_diff
        contains
        recursive subroutine div_difference(X, Y, num_points,           &
            coefficients, array_size)
            
            implicit none
            integer, intent(in) :: num_points, array_size
            integer :: whale, dolphin, shark
            double precision, dimension(num_points) :: X, Y
            double precision, dimension(array_size) :: coefficients

            write(*,*),"X: ",X
            write(*,*),"Y: ",Y

            ! Loop through all points except last one
            do whale = 1, num_points - 1
                ! subtract next Y from this Y, store in current Y
                    ! position
                Y(whale) = Y(whale + 1) - Y(whale)

                ! subtract next X from this X, store in this X position
                X(whale) = X(whale + 1) - X(whale)

                ! Divide current X value by current Y value, store in Y
                    ! value position
                Y(whale) = Y(whale)/X(whale)
            enddo

            ! Store zeroth Y value as coefficient in position: 
                ! (array_size - num_points + 1). Add one because fortran
                ! uses 1-indexed arrays by default
            coefficients(array_size - num_points + 1) = Y(1)

            ! Write output
            write(*,*),"X:"
            do dolphin = 1, num_points
                write(*,*),X(dolphin)
            enddo

            write(*,*),"Y:"
            do shark = 1, num_points
                write(*,*),Y(shark)
            enddo

            write(*,*),"Coefficient: ", Y(1)
            write(*,*),"Array Size: ", array_size
            write(*,*),"Num Points: ", num_points
            write(*,*),"Iteration: ", array_size - num_points + 1
            write(*,*)

            if (num_points.gt.1) then
                call div_difference(X, Y, num_points - 1, coefficients, &
                array_size)
            endif
        end subroutine
        end module
